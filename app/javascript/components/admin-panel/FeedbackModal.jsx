import React, { Component } from 'react';
import Axios from 'axios';


class FeedbackModal extends Component {

  constructor(props) {
    super(props);
    this.state = {
      userFeedback: [],
      postID: props.postId
    };
    // this.fetchFeedback();
  };

  async fetchFeedback() {
    let tokenHeader = document.querySelectorAll('meta[name="csrf-token"]')[0].content;
    let response = await Axios({
      method: 'get',
      url: 'http://localhost:3000/api/v1/posts/' + this.state.postId + '/feedback',
      data:{
      },
      headers: { 'X-CSRF-TOKEN' : tokenHeader }
    });
    this.setState({
      posts: response.data.data
    });
  }

  render() {

  }
}