import React from 'react';
import { shallow } from 'enzyme';
import { describe, it } from 'mocha';

import App from '../../components/App';
import Header from '../../components/Header';
import Footer from '../../components/Footer';
import FeedbackStore from '../../stores/FeedbackStore';

const assert = require('assert');

describe('test the App', () => {
  it('App should have header and footer', () => {
    const stores = {
      feedbackStore: new FeedbackStore()
    };
    const app = shallow(<App stores={stores} />).dive();
    const header = app.find(Header);
    const footer = app.find(Footer);
    assert.strictEqual(header.props().title, 'Tell us what you think');
    assert.strictEqual(footer.props().content, 'Copyright: AppFolio Inc. Onboarding');
  });
});
