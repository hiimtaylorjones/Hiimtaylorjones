import React, { Component } from 'react';
import '../../packs/styles/components/banner-notification';

class BannerNotification extends Component {

  constructor(props) {
    super(props);

    this.state = {
      message: this.props.message,
      status: this.props.status,
      hidden: false
    };
    this.closeNotification = this.closeNotification.bind(this);
  };

  closeNotification = () => {
    this.setState({ hidden: true });
  };

  render() {
    const { hidden, status } = this.state;
    let color;

    if (status === 200) {
      color = "is-success";
    } else if (status === 422) {
      color = "is-warning";
    } else {
      color = "is-info";
    }

    return (
      <div className={`notification ${hidden ? "hidden" : ""} ${color}`}>
        <button className="delete" onClick={this.closeNotification}></button>
        {this.state.message}
      </div>
    );
  }
}

export default BannerNotification;