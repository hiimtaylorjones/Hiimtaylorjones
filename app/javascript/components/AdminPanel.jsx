import React, { Component } from 'react';
import PageView from './admin-panel/PageView.jsx';
import '../post_rating/styles/admin-panel';

function PostView(props) {
  return (
    <div className="post-view">
      <h3>Looking at Post View!</h3>
    </div>
  );
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