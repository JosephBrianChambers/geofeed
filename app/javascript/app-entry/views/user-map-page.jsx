import React from 'react';
import { renderToString } from 'react-dom/server'
import AuthApi from '../apis/auth'
import UserApi from '../apis/user'
import styles from './user-map-page-styles'

class MapUserPage extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
    };

    this.renderEventMoments = this.renderEventMoments.bind(this)
    this.handleMomentClick = this.handleMomentClick.bind(this)
  }

  componentDidMount() {
    this.setState({ map: this.initMap() }, () => { this.registerMapHandlers() })
  }

  initMap() {
    mapboxgl.accessToken = 'pk.eyJ1IjoiaGVpZC1qb2huIiwiYSI6ImNqZ2w1ZWxsZjFpNngzMmw0bzl0MmZra2YifQ.PoNBBITbAVBFGBc_nWRpFw';

    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v9',
      center: [-96, 37.8],
      zoom: 3,
    })

    const draw = new MapboxDraw({
      displayControlsDefault: false,
      controls: {
        polygon: true,
        trash: true,
      },
    })

    map.addControl(draw);

    return map
  }

  registerMapHandlers() {
    const map = this.state.map;
    map.on('draw.create', this.renderEventMoments);
    map.on('draw.update', this.renderEventMoments);
    map.on('click', 'moments', this.handleMomentClick);
    map.on('mouseenter', 'moments', () => { map.getCanvas().style.cursor = 'pointer' });
    map.on('mouseleave', 'moments', () => { map.getCanvas().style.cursor = '' });
  }

  handleMomentClick(e) {
    const map = this.state.map;
    const coordinates = e.features[0].geometry.coordinates.slice();
    // const description = e.features[0].properties.description;

    // Ensure that if the map is zoomed out such that multiple
    // copies of the feature are visible, the popup appears
    // over the copy being pointed to.
    while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
        coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
    }

    new mapboxgl.Popup()
      .setLngLat(coordinates)
      .setHTML(renderToString(<h2>YOYo</h2>))
      .addTo(map);
  }

  renderEventMoments(e) {
    const geoFence = e.features[0]
    console.log(geoFence)

    const geoJsonPoints = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "geometry": {
            "type": "Point",
            "coordinates": [-77.03238901390978, 38.913188059745586]
          },
          "properties": {
            "title": "Mapbox DC",
            "icon": "monument"
          }
        },
        {
          "type": "Feature",
          "geometry": {
            "type": "Point",
            "coordinates": [-122.414, 37.776]
          },
          "properties": {
            "title": "Mapbox SF",
            "icon": "harbor"
          }
        }
      ]
    }

    this.state.map.addLayer({
      "id": "moments",
      "type": "symbol",
      "source": {
        "type": "geojson",
        "data": geoJsonPoints,
      },
      "layout": {
        "icon-image": "{icon}-15",
        "text-field": "{title}",
        "text-font": ["Open Sans Semibold", "Arial Unicode MS Bold"],
        "text-offset": [0, 0.6],
        "text-anchor": "top"
      }
    });
  }

  render() {
    return (
      <div>
        <div id="map" className={styles.map}></div>
      </div>
    );
  }
}

export default MapUserPage;
