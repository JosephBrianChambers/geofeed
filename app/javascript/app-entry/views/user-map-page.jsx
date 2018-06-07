import React from 'react';
import AuthApi from '../apis/auth'
import UserApi from '../apis/user'
import styles from './user-map-page-styles'

class LoginForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentDidMount() {
    mapboxgl.accessToken = 'pk.eyJ1IjoiaGVpZC1qb2huIiwiYSI6ImNqZ2w1ZWxsZjFpNngzMmw0bzl0MmZra2YifQ.PoNBBITbAVBFGBc_nWRpFw';

    const initialMapAttrs = {
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v9',
    }

    const map = new mapboxgl.Map(initialMapAttrs)
  }

  render() {
    return (
      <div>
        <div id="map" className={styles.map}></div>
      </div>
    );
  }
}

export default LoginForm;
