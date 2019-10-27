import React from 'react';
import { shallow } from 'enzyme';
import { describe, it } from 'mocha';

import App from '../../components/App';
import Header from '../../components/Header';
import Form from '../../components/Form';
import Footer from '../../components/Footer';

const assert = require('assert');

describe('test the App', () => {
  it('App should have header and footer', () => {
    const app = shallow(<App />);
    const header = app.find(Header);
    const footer = app.find(Footer);
    assert.strictEqual(header.props().title, 'Tell us what you think');
    assert.strictEqual(footer.props().content, 'Copyright: AppFolio Inc. Onboarding');
  });

  it('App should have a Form', () => {
    const app = shallow(<App />);
    const form = app.find(Form);
    assert.strictEqual(form.length, 1);
  });
});
