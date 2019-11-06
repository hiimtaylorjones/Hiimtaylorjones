import React, { Component } from 'react';
import Axios from 'axios';

class PageView extends Component {

  constructor(props) {
    super(props);
    this.state = {
      pages: []
    };
    this.fetchPages();
  };

  async fetchPages() {
    let tokenHeader = document.querySelectorAll('meta[name="csrf-token"]')[0].content;
    let response = await Axios({
      method: 'get',
      url: 'http://localhost:3000/api/v1/pages',
      data:{
      },
      headers: { 'X-CSRF-TOKEN' : tokenHeader }
    });
    this.setState({
      pages: response.data
    });
  }

  render() {
    return (
      <div className="page-view">
        <h3>Looking at Page View!</h3>
        <table className="table table-striped is-fullwidth">
          <tbody>
            <tr>
              <th>Title</th>
              <th colSpan="3">Actions</th>
            </tr>
            <tr>
              { this.state.pages.map(page => <td key={page.id}>{page.title}</td>) }
              <td><button className="button is-warning">Edit</button></td>
              <td><button className="button is-danger">Destroy</button></td>
            </tr>
          </tbody>
        </table>
        <button className="button is-success">New Page</button>
      </div>
    );
  }
}

export default PageView;