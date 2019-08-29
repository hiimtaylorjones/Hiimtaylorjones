import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import '../post_rating/styles/post-rating';

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
      <h4>{props.message}</h4>
      <textarea value={props.comments} className="feedback-text" onChange={props.onInput}></textarea>
    </div>
  );
}

class PostRating extends Component {
  constructor(props) {
    super(props);
    this.state = { 
      rating: "",
      additionalComments: "",
      highlightColor: ""
    };
    this.setRating = this.setRating.bind(this);
    this.captureFeedback = this.captureFeedback.bind(this);
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
        additionalComments: "",
        highlightColor: highlightColor
      }
    );
  };

  captureFeedback(event) {
    this.setState({additionalComments: event.target.value});
  }

  handleSubmit(event) {
    console.log("Review Sent")
    event.preventDefault();
  }
  
  render() {
    let message;
    const rating = this.state.rating;

    if (["1", "2"].includes(rating)){
      message = "What did you not like about this post?";
    } else if (rating === "3") {
      message = "What about this post seems bland?";
    } else if (["4", "5"].includes(rating)) {
      message = "What was the strongest part of this post?";
    }

    return(
      <div className="feedback-form">
        <div className="rating-form">
          <h3>So, what'd you think of this post?</h3>
          <div className="input-group">
            <label>Rate it on a scale of 1 to 5</label><br />
            <RatingButton value="1" highlighted={this.state.rating === "1" ? true : false} highlightColor={this.state.highlightColor} onClick={this.setRating} />
            <RatingButton value="2" highlighted={this.state.rating === "2" ? true : false} highlightColor={this.state.highlightColor} onClick={this.setRating} />
            <RatingButton value="3" highlighted={this.state.rating === "3" ? true : false} highlightColor={this.state.highlightColor} onClick={this.setRating} />
            <RatingButton value="4" highlighted={this.state.rating === "4" ? true : false} highlightColor={this.state.highlightColor} onClick={this.setRating} />
            <RatingButton value="5" highlighted={this.state.rating === "5" ? true : false} highlightColor={this.state.highlightColor} onClick={this.setRating} />
          </div>
        </div>
        <div className="feedback-form">
          <FeedbackForm message={message} onChange={this.captureFeedback} />
        </div>
        <button className="submit-button" onClick={this.handleSubmit}>Send Feedback</button>
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