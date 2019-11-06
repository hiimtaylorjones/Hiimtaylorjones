import React, { Component } from 'react';
import Axios from 'axios';

class PostView extends Component {

  constructor(props) {
    super(props);
    this.state = {
      posts: []
    };
    this.fetchPosts();
  };

  async fetchPosts() {
    let tokenHeader = document.querySelectorAll('meta[name="csrf-token"]')[0].content;
    let response = await Axios({
      method: 'get',
      url: 'http://localhost:3000/api/v1/posts',
      data:{
      },
      headers: { 'X-CSRF-TOKEN' : tokenHeader }
    });
    this.setState({
      posts: response.data
    });
  }

  render() {
    return (
      <div className="post-view">
        <h3>Looking at Post View!</h3>
        <table className="table table-striped is-fullwidth">
          <tbody>
            <tr>
              <th>Title</th>
              <th colSpan="3">Actions</th>
            </tr>
            <tr>
              { this.state.posts.map(post => <td key={post.id}>{post.title}</td>) }
              <td><button className="button is-warning">Edit</button></td>
              <td><button className="button is-danger">Destroy</button></td>
            </tr>
          </tbody>
        </table>
        <button className="button is-success">New post</button>
      </div>
    );
  }
}

export default PostView;