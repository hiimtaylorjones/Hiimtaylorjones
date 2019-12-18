import React, { Component } from 'react';
import Axios from 'axios';
import Modal from 'react-modal';
import '../../packs/styles/components/modal.scss';

var appElement = document.getElementById('example');
Modal.setAppElement(appElement);

const customStyles = {
  content : {
    top                   : '50%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    marginRight           : '-50%',
    transform             : 'translate(-50%, -50%)'
  }
};

class FeedbackModal extends Component {

  constructor(props) {
    super(props);
    this.state = {
      userFeedback: [],
      postID: props.postId,
      modalIsOpen: false,
      setIsOpen: false
    };
    this.fetchFeedback();
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
          style={customStyles}
        >

          <div className="modal-header">
            <div className="level">
              <div className="level-left modal-title">
                <h2 ref={this.state.postID}>Post Feedback</h2>
              </div>
              
              <div className="level-right">
                <button onClick={this.closeModal}>close</button>
              </div>
            </div>
          </div>
          
          <div className="modal-body">
            <h3>I am a modal</h3>
            {this.state.userFeedback}
          </div>
          
        </Modal>
      </div>);
  }
}

export default FeedbackModal;