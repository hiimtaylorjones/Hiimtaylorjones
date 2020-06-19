import React, { Component } from 'react';
import Axios from 'axios';
import { API } from '../utilities/api.js';

class PageForm extends Component {

  constructor(props) {
    super(props);
    this.state = {
      page: this.props.page,
    };
  };

  render() {
    return (
      <div className="page-form">
        <h3>Looking at Page Form!</h3>
          <form>
            <div className="field">
              <label name="title">Title</label>
              <div className="control">
                <input type="text" value={this.props.page.title} className="input"></input>
              </div>
            </div>

          <div className="field">
            <label name="content">Content</label>
            <div className="control">
              <textarea value={this.props.page.content} className="textarea" rows="25"></textarea>
            </div>
          </div>
      
          <div className="text-center">
            <button type="submit" className="button is-primary">Submit</button>
          </div>
        </form>
      </div>
    );
  }
}

export default PageForm;