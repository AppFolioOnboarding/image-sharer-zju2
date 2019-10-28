import React, { Component } from 'react';
import Header from './Header';
import Form from './Form';
import Footer from './Footer';

class App extends Component {
  /* Add Prop Types check*/
  render() {
    return (
      <div>
        <Header title="Tell us what you think" />
        <Form />
        <Footer content="Copyright: AppFolio Inc. Onboarding" />
      </div>
    );
  }
}

export default (App);
