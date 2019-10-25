import React from 'react';
import { shallow } from 'enzyme';
import { describe, it } from 'mocha';

import Footer from '../../components/Footer';

const assert = require('assert');

describe('<Footer />', () => {
  const wrapper = shallow(<Footer content="This is the footer" />);

  it('Should show correct provided Footer ', () => {
    assert.strictEqual(wrapper.find('p.text-center').text(), 'This is the footer');
  });

  it('Should appear with expected fontsize', () => {
    assert.strictEqual(wrapper.find('p.text-center').props().style.fontSize, '10px');
  });
});
