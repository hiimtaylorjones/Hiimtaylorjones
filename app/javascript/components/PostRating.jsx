import React, { Component } from 'react';
import '../post_rating/styles/post-rating';
import Axios from 'axios';

function RatingButton(props) {
  let modifiedButton;

  return (
    <button name="rating" 
      className={props.highlighted === true ? props.highlightColor : ""} 
      value={props.value} 
      onClick={props.onClick}>{props.value}</button>
  );
}

function FeedbackForm(props) {
  return (
    <div className="feedback-form">
      <h4>{props.feedbackQuestion}</h4>
      <textarea className="feedback-text" onChange={props.changeAction}></textarea>
    </div>
  );
}

class PostRating extends Component {
  constructor(props) {
    super(props);
    this.state = { 
      rating: "",
      message: "",
      highlightColor: "",
      post_id: props.post_id
    };
    this.setRating = this.setRating.bind(this);
    this.captureFeedback = this.captureFeedback.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this)
  };

  setRating(event) {
    let highlightColor;
    let rating = event.target.value;

    if (["1", "2"].includes(rating)){
      highlightColor = "highlighted-red";  
    } else if (rating === "3") {
      highlightColor = "highlighted-yellow";
    } else if (["4", "5"].includes(rating)) {
      highlightColor = "highlighted-green";
    }

    this.setState(
      { 
        rating: rating,
        highlightColor: highlightColor
      }
    );
  };

  captureFeedback(event) {
    console.log(event.target.value);
    this.setState({message: event.target.value});
  }

  async handleSubmit(event) {
    event.preventDefault();
    // Grab token to authenticate
    let tokenHeader = document.querySelectorAll('meta[name="csrf-token"]')[0].content;
    console.log("State: ");
    console.log(this.state.rating);
    console.log(this.state.message);
    console.log(this.state.post_id);
    await Axios({
      method: 'post',
      url: 'http://localhost:3000/api/v1/feedback/create',
      data:{
        comment: {
          post_id: this.state.post_id,
          rating: this.state.rating,
          message: this.state.message
        }
      },
      headers: { 'X-CSRF-TOKEN' : tokenHeader }
    });
    console.log('Feedback sent!');
  }
  
  render() {
    let question;
    const rating = this.state.rating;

    if (["1", "2"].includes(rating)){
      question = "What did you not like about this post?";
    } else if (rating === "3") {
      question = "What about this post seems bland?";
    } else if (["4", "5"].includes(rating)) {
      question = "What was the strongest part of this post?";
    }

    return(
      <div className="post-rating-form">
        <div className="rating-form">
          <h3>So, what'd you think of this post?</h3>
          <div className="input-group">
            <label>Rate it on a scale of 1 to 5</label><br />
            <RatingButton value="1" highlighted={this.state.rating === "1" ? true : false} 
              highlightColor={this.state.highlightColor} onClick={this.setRating} />
            <RatingButton value="2" highlighted={this.state.rating === "2" ? true : false} 
              highlightColor={this.state.highlightColor} onClick={this.setRating} />
            <RatingButton value="3" highlighted={this.state.rating === "3" ? true : false} 
              highlightColor={this.state.highlightColor} onClick={this.setRating} />
            <RatingButton value="4" highlighted={this.state.rating === "4" ? true : false} 
              highlightColor={this.state.highlightColor} onClick={this.setRating} />
            <RatingButton value="5" highlighted={this.state.rating === "5" ? true : false} 
              highlightColor={this.state.highlightColor} onClick={this.setRating} />
          </div>
        </div>
        <div className="feedback-form">
          <FeedbackForm feedbackQuestion={question} changeAction={this.captureFeedback} />
        </div>
        <button className="submit-button" onClick={this.handleSubmit}>Send Feedback</button>
      </div>
    );
  }
}

export default PostRating;