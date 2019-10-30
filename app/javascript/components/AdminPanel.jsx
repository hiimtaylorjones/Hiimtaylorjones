import React, { Component } from 'react';
import '../post_rating/styles/admin-panel';
import Axios from 'axios';

function PostView(props) {
  return (
    <div className="post-view">
      <h3>Looking at Post View!</h3>
    </div>
  );
}

class PageView extends Component {

  constructor(props) {
    super(props);
    let fetchedPages = this.fetchPages();
    this.state = {
      currentView: "post",
      pages: fetchedPages
    };
  };

  fetchPages() {
    let tokenHeader = document.querySelectorAll('meta[name="csrf-token"]')[0].content;
    return Axios({
      method: 'get',
      url: 'http://localhost:3000/api/v1/pages',
      data:{
      },
      headers: { 'X-CSRF-TOKEN' : tokenHeader }
    });
  }

  render() {
    return (
      <div className="page-view">
        <h3>Looking at Page View!</h3>
      </div>
    );
  }
}

function MetricsView(props) {
  return (
    <div className="metrics-view">
      <h3>Looking at Metrics View!</h3>
    </div>
  );
}

class AdminPanel extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentView: "post"
    };
    this.switchView = this.switchView.bind(this);
  };

  switchView(event) {
    this.setState({currentView: event.target.getAttribute("value")});
  } 

  render() {
    let renderSection;
    if (this.state.currentView === "post") {
      renderSection = <PostView />; 
    } else if (this.state.currentView === "page") {
      renderSection = <PageView />;
    } else {
      renderSection = <MetricsView />;
    }

    return(
      <div>
        <div className="tabs is-medium is-centered">
          <ul>
            <li className={ this.state.currentView === "post" ? "is-active" : ""}><a value="post" onClick={this.switchView}>Posts</a></li>
            <li className={ this.state.currentView === "page" ? "is-active" : ""}><a value="page" onClick={this.switchView}>Pages</a></li>
            <li className={ this.state.currentView === "metrics" ? "is-active" : ""}><a value="metrics" onClick={this.switchView}>Metrics</a></li>
          </ul>
        </div>
        {renderSection}
      </div>
    );
  }
}

export default AdminPanel;