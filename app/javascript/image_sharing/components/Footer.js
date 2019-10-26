import React, { Component } from 'react';
import { Col, Row } from 'reactstrap';
import PropTypes from 'prop-types';

class Footer extends Component {
  /* Implement your Footer component here */
  static propTypes = {
    content: PropTypes.string.isRequired
  };

  render() {
    const content = this.props.content;
    return (
      <div>
        <Row>
          <Col lg={{ size: 10, offset: 1 }}>
            <p className='text-center' style={{ fontSize: '10px' }}>
              {content}
            </p>
          </Col>
        </Row>
      </div>
    );
  }
}

export default Footer;
