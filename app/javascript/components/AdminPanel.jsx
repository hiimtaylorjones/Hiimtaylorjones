import React, { Component } from 'react';

import PageView from './admin-panel/PageView.jsx';
import PostView from './admin-panel/PostView.jsx';
import '../post_rating/styles/admin-panel';

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
    }

    return(
      <div>
        <div className="tabs is-medium is-centered">
          <ul>
            <li className={ this.state.currentView === "post" ? "is-active" : ""}><a value="post" onClick={this.switchView}>Posts</a></li>
            <li className={ this.state.currentView === "page" ? "is-active" : ""}><a value="page" onClick={this.switchView}>Pages</a></li>
          </ul>
        </div>
        {renderSection}
      </div>
    );
  }
}

export default AdminPanel;