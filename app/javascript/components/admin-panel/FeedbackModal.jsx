import React, { Component } from 'react';
import Axios from 'axios';
import Modal from 'react-modal';


var appElement = document.getElementById('example');
Modal.setAppElement(appElement);

class FeedbackModal extends Component {

  constructor(props) {
    super(props);
    this.state = {
      userFeedback: [],
      postID: props.postId,
      modalIsOpen: false,
      setIsOpen: false
    };
    // this.fetchFeedback();
    this.openModal = this.openModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
  };

  openModal() {
    this.setState({modalIsOpen: true});
  }

  closeModal(){
    this.setState({modalIsOpen: false});
  }

  async fetchFeedback() {
    let tokenHeader = document.querySelectorAll('meta[name="csrf-token"]')[0].content;
    let response = await Axios({
      method: 'get',
      url: 'http://localhost:3000/api/v1/posts/' + this.state.postId + '/feedback',
      data:{
      },
      headers: { 'X-CSRF-TOKEN' : tokenHeader }
    });
    this.setState({
      userFeedback: response.data.data
    });
  }

  render() {
    return(
      <div>
        <button onClick={this.openModal}>Open Modal</button>
        <Modal
          isOpen={this.state.modalIsOpen}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          contentLabel="Example Modal"
        >

          <h2 ref={this.state.postID}>Post Feedback</h2>
          <button onClick={this.closeModal}>close</button>
          <div>I am a modal</div>
          <form>
            <input />
            <button>tab navigation</button>
            <button>stays</button>
            <button>inside</button>
            <button>the modal</button>
          </form>
        </Modal>
      </div>);
  }
}

export default FeedbackModal;