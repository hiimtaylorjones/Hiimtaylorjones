import React, { Component } from 'react';
import Axios from 'axios';
import { API } from '../utilities/api.js';
import Notification from '../utilities/BannerNotification.jsx';

class PageForm extends Component {

  constructor(props) {
    super(props);
    this.state = {
      title: this.props.page.title,
      content: this.props.page.content,
      responseStatus: null,
      responseMessage: null
    };
    this.updatePage = this.updatePage.bind(this);
    this.updateTitle = this.updateTitle.bind(this);
    this.updateContent = this.updateContent.bind(this);
  };

  async updatePage(event) {
    event.preventDefault();
    let apiUrl = API.protocol + API.host + "/api/v1/pages/" + this.props.page.id;
    let tokenHeader = document.querySelectorAll('meta[name="csrf-token"]')[0].content;
    let response = await Axios({
      method: 'patch',
      url: apiUrl,
      data: {
        id: this.props.page.id,
        page:  {
          title: this.state.title,
          content: this.state.content
        }
      },
      headers: { 'X-CSRF-TOKEN' : tokenHeader }
    });

    this.setState({
      responseMessage: response.data.message,
      responseStatus: response.data.status
    });

    console.log(response.data.message);
  }

  updateTitle(event) {
    this.setState({title: event.target.value});
  }

  updateContent(event) {
    this.setState({content: event.target.value});
  }

  render() {

    let notification;
    if (this.state.responseMessage != null) {
      notification = <Notification status={this.state.responseStatus} message={this.state.responseMessage} />;
    }

    return (
      <div className="page-form">
        {notification}
        <h3>Looking at Page Form!</h3>
          <form>
            <div className="field">
              <label name="title">Title</label>
              <div className="control">
                <input type="text" value={this.state.title} onChange={this.updateTitle} className="input"></input>
              </div>
            </div>

          <div className="field">
            <label name="content">Content</label>
            <div className="control">
              <textarea value={this.state.content} onChange={this.updateContent} className="textarea" rows="25"></textarea>
            </div>
          </div>
      
          <div className="text-center">
            <button type="submit" className="button is-primary" onClick={this.updatePage}>Submit</button>
          </div>
        </form>
      </div>
    );
  }
}

export default PageForm;