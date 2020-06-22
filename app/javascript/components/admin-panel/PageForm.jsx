import React, { Component } from 'react';
import Axios from 'axios';
import { API } from '../utilities/api.js';

class PageForm extends Component {

  constructor(props) {
    super(props);
    this.state = {
      page: this.props.page,
    };
    this.updatePage = this.updatePage.bind(this);
    this.updatePageObject = this.updatePageObject.bind(this);
  };

  async updatePage(event) {
    event.preventDefault();
    let apiUrl = API.protocol + API.host + "/api/v1/pages/" + this.props.page.id;
    let tokenHeader = document.querySelectorAll('meta[name="csrf-token"]')[0].content;
    let response = await Axios({
      method: 'patch',
      url: apiUrl,
      data: {
        page: this.state.page
      },
      headers: { 'X-CSRF-TOKEN' : tokenHeader }
    });
    console.log(response.data.message);
  }

  updatePageObject() {
    console.log("You updated me!");
  }

  render() {
    return (
      <div className="page-form">
        <h3>Looking at Page Form!</h3>
          <form>
            <div className="field">
              <label name="title">Title</label>
              <div className="control">
                <input type="text" value={this.props.page.title} onChange={this.updatePageObject} className="input"></input>
              </div>
            </div>

          <div className="field">
            <label name="content">Content</label>
            <div className="control">
              <textarea value={this.props.page.content} onChange={this.updatePageObject} className="textarea" rows="25"></textarea>
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