import React from 'react';
import ReactDOM from 'react-dom';
import { renderToString } from 'react-dom/server'
import AuthApi from '../apis/auth'
import MomentsApi from '../apis/moments'
import EventsApi from '../apis/events'
import styles from './user-map-page-styles'
import MapMomentPopup from './components/map-moment-popup'

class MapUserPage extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      errorMessage: "",
      momentGeojsonFeatures: []
    };

    this.createEvent = this.createEvent.bind(this)
    this.handleMomentClick = this.handleMomentClick.bind(this)
    this.setMomentsSourceData = this.setMomentsSourceData.bind(this)
  }

  componentDidMount() {
    this.setState({ map: this.createMap() }, () => { this.initializeMap() })
  }

  createMap() {
    mapboxgl.accessToken = 'pk.eyJ1IjoiaGVpZC1qb2huIiwiYSI6ImNqZ2w1ZWxsZjFpNngzMmw0bzl0MmZra2YifQ.PoNBBITbAVBFGBc_nWRpFw';

    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v9',
      center: [-122.4194, 37.7749],
      zoom: 11,
    })
  }

  initializeMap() {
    const map = this.state.map;

    const drawControl = new MapboxDraw({
      displayControlsDefault: false,
      controls: {
        polygon: true,
        trash: true,
      },
    })

    map.on('style.load', () => {
      map.addSource("momentsSource", {
        "type": "geojson",
        "data": {
          "type": "FeatureCollection",
          "features": this.state.momentGeojsonFeatures
        }
      });

      map.addLayer({
        "id": "moments",
        "type": "symbol",
        "source": "momentsSource",
        "layout": {
          "icon-image": "heliport-15",
          "icon-allow-overlap": true,
          "icon-size": 3,
        }
      });
    });

    map.addControl(drawControl)
    map.on('draw.create', this.createEvent);
    map.on('draw.update', this.createEvent);
    map.on('click', 'moments', this.handleMomentClick);
    map.on('mouseenter', 'moments', () => { map.getCanvas().style.cursor = 'pointer' });
    map.on('mouseleave', 'moments', () => { map.getCanvas().style.cursor = '' });
  }

  handleMomentClick(e) {
    const map = this.state.map;
    const feature = e.features[0]
    const coordinates = feature.geometry.coordinates.slice();

    // Ensure that if the map is zoomed out such that multiple
    // copies of the feature are visible, the popup appears
    // over the copy being pointed to.
    while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
      coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
    }

    MomentsApi.get(feature.properties.id).then((response) => {
      const data = response.data
      const popupHtml = renderToString(
        <MapMomentPopup
          authorUrl="https://www.google.com"
          authorAvatarUrl={data.author.avatar_url}
          authorName={data.author.name}
          caption={data.caption}
          imageUrl={data.medias[0] && data.medias[0].url}
        />
      )

      new mapboxgl.Popup({ anchor: 'center' })
        .setLngLat(coordinates)
        .setHTML(popupHtml)
        .addTo(map);
    })
  }

  createEvent(e) {
    this.setState({ errorMessage: "" })

    const eventAttrs = {
      geo_fence: e.features[0],
      end_time: Math.floor(Date.now() / 1000),
      start_time: Math.floor(Date.now() / 1000) - (60 * 60 * 2), // 2 hours
    }

    let eventId

    EventsApi.create(eventAttrs).then((r) => {
      eventId = r.data.id;
      return EventsApi.fetchContent(r.data.id)
    }).then((_) => (
      EventsApi.get(eventId)
    )).then((r) => {
      const momentFeatures = r.data.moments.map(m => m.geojson_feature)
      const momentGeojsonFeatures = this.state.momentGeojsonFeatures.concat(momentFeatures)
      this.setState({ momentGeojsonFeatures }, this.setMomentsSourceData)
    }).catch((error) => {
      this.setState({ errorMessage: error.response.data.message})
    })
  }

  setMomentsSourceData() {
    const sourceData = {
      "type": "FeatureCollection",
      "features": this.state.momentGeojsonFeatures
    }

    this.state.map.getSource('momentsSource').setData(sourceData)
  }

  render() {
    return (
      <div>
        <div id="map" className={styles.map}></div>
        <p>{this.state.errorMessage}</p>
      </div>
    );
  }
}

export default MapUserPage;
