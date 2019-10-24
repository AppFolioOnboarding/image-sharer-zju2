import React from 'react';
import { shallow } from 'enzyme';
import { describe, it } from 'mocha';

import Header from '../../components/Header';

const assert = require('assert');

describe('<Header />', () => {
  const wrapper = shallow(<Header title="This is the Header" />);

  it('Show the correct provided header', () => {
    assert.strictEqual(wrapper.find('h3.text-center').text(), 'This is the Header');
  });
});
