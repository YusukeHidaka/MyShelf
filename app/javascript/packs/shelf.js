'use strict';
import React, {Component} from 'react';
import ReactDOM from 'react-dom'

class Shelf extends React.Component {
  render() {
    const {t} = this.props;

    return (
      <div>
        <h1>reactの本棚です。</h1>
      </div>
    );
  }
}
document.addEventListener("DOMContentLoaded", e => {
  ReactDOM.render(<Shelf />, document.getElementById('ones-shelf'))
})
