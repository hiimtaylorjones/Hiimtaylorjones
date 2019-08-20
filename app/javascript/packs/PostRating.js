// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { Component } from 'react';
import ReactDOM from 'react-dom'
import './styles/post-rating'

class PostRating extends Component {
  constructor(props) {
    super(props);
    this.state = { 
      rating: "",
      email: ""
    };
    this.handleChange = this.handleChange.bind(this);
  };

  handleChange(event) {
    this.setState({ [event.target.name]: event.target.value });
  };
  
  render() {
    return(
      <div className="rating-form">
        <h3>So, what'd you think of this post?</h3>
        <div className="input-group">
          <label>Give it a Rating out of 5</label><br />
          <button name="time" value="1" onClick={this.handleChange}>1</button>
          <button name="time" value="2" onClick={this.handleChange}>2</button>
          <button name="time" value="3" onClick={this.handleChange}>3</button>
          <button name="time" value="4" onClick={this.handleChange}>4</button>
          <button name="time" value="5" onClick={this.handleChange}>5</button>
        </div>
      </div>
    );
  }
}


document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <PostRating email="" rating="3" />,
    document.getElementById('react-comment-section'),
  )
})