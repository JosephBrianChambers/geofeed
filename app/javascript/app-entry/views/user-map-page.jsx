import React from 'react';
import ReactDOM from 'react-dom';
import { renderToString } from 'react-dom/server'
import MomentsApi from '../apis/moments'
import EventsApi from '../apis/events'
import styles from './user-map-page-styles'
import MapMomentPopup from './components/map-moment-popup'
import citizenIconPath from '../../images/icons/citizen.jpeg'
import twitterIconPath from '../../images/icons/twitter.jpeg'

mapboxgl.accessToken = 'pk.eyJ1IjoiaGVpZC1qb2huIiwiYSI6ImNqZ2w1ZWxsZjFpNngzMmw0bzl0MmZra2YifQ.PoNBBITbAVBFGBc_nWRpFw';

class MapUserPage extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      errorMessage: "",
    };

    this.createEvent = this.createEvent.bind(this)
    this.handleMomentClick = this.handleMomentClick.bind(this)
  }

  componentDidMount() {
    this.map = new mapboxgl.Map({
      container: this.mapContainer,
      style: 'mapbox://styles/mapbox/streets-v9',
      center: [-122.4194, 37.7749],
      zoom: 11,
    })

    this.initializeMap()
    this.momentGeojsonFeatures = []
  }

  componentWillUnmount() {
    this.map.remove();
  }

  initializeMap() {
    const map = this.map;

    const citizenLogoImgTag = new Image()
    citizenLogoImgTag.src = citizenIconPath
    const twitterLogoImgTag = new Image()
    twitterLogoImgTag.src = twitterIconPath

    const drawControl = new MapboxDraw({
      displayControlsDefault: false,
      controls: {
        polygon: true,
        trash: true,
      },
    })

    map.addControl(drawControl)
    map.on('draw.create', this.createEvent);
    map.on('draw.update', this.createEvent);

    map.on('load', () => {
      map.addSource("momentsSource", {
        "type": "geojson",
        "data": {
          "type": "FeatureCollection",
          "features": this.momentGeojsonFeatures
        }
      });

      map.addImage('citizenMarkerIcon', citizenLogoImgTag);
      map.addImage('twitterMarkerIcon', twitterLogoImgTag);

      ["citizen", "twitter"].forEach(contentProviderCode => {
        const layerId = `poi-${contentProviderCode}`;

        map.addLayer({
          "id": layerId,
          "type": "symbol",
          "source": "momentsSource",
          "layout": {
            "icon-image": `${contentProviderCode}MarkerIcon`,
            "icon-allow-overlap": true,
            "icon-size": 1,
          },
          "filter": ["==", "content_provider_code", contentProviderCode]
        });

        map.on('click', layerId, this.handleMomentClick);
        map.on('mouseenter', layerId, () => { map.getCanvas().style.cursor = 'pointer' });
        map.on('mouseleave', layerId, () => { map.getCanvas().style.cursor = '' });
      });
    });
  }

  handleMomentClick(e) {
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
        .addTo(this.map);
    });
  }

  createEvent(e) {
    let eventId
    this.setState({ errorMessage: "" })

    const eventAttrs = {
      geo_fence: e.features[0],
      end_time: Math.floor(Date.now() / 1000),
      start_time: Math.floor(Date.now() / 1000) - (60 * 60 * 2), // 2 hours
    }

    EventsApi.create(eventAttrs).then((r) => (
      eventId = r.data.id
    )).then((_) => (
      EventsApi.fetchContent(eventId)
    )).then((_) => (
      EventsApi.get(eventId)
    )).then((r) => {
      const momentFeatures = r.data.moments.map(m => m.geojson_feature)
      this.momentGeojsonFeatures = this.momentGeojsonFeatures.concat(momentFeatures)

      this.map.getSource('momentsSource').setData({
        "type": "FeatureCollection",
        "features": this.momentGeojsonFeatures
      })
    }).catch((error) => {
      this.setState({ errorMessage: error.response.data.message})
    })
  }

  render() {
    return (
      <div>
        <div id="map" className={styles.map} ref={el => this.mapContainer = el}></div>
        <p>{this.state.errorMessage}</p>
      </div>
    );
  }
}

export default MapUserPage;
