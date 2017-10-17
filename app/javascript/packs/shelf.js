'use strict';

import React, {Component} from 'react';

class Shelf extends Component {
  render() {
    const {t} = this.props;

    return (
      <div>
        <h1>本棚です。</h1>
        <h1>データの受け渡しなどはのちにします。</h1>
      </div>
    );
  }
}

export default Shelf;


// Hello.defaultProps = {
//   name: 'David'
// }
//
// Hello.propTypes = {
//   name: PropTypes.string
// }
