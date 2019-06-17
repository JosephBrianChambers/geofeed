import React from 'react';
import styles from './map-moment-popup-styles'

class mapMomentPopup extends React.Component {
  constructor(props) {
    super(props);

    this.state = {};

    // this.createEvent = this.createEvent.bind(this)
  }

  render() {
    return (
      <div className={styles.popupContainer}>
        <header>
          <a href={this.props.authorUrl}>
            <img src={this.props.authorAvatarUrl} />
            {this.props.authorName}
          </a>
        </header>
        <section>
          <img className={styles.media} src={this.props.imageUrl} />
          <p>{this.props.caption}</p>
        </section>

      </div>
    );
  }
}

export default mapMomentPopup;

