import React from 'react';
import { shallow } from 'enzyme';
import { describe, it } from 'mocha';
import sinon from 'sinon';

import Form from '../../components/Form';

const assert = require('assert');

describe('test the form', () => {
  const sandbox = sinon.createSandbox();

  const stores = {
    feedbackStore: {
      name: 'Adam',
      comment: 'Good!',
      setName: sandbox.spy(),
      setComment: sandbox.spy()
    }
  };

  it('should have valid rows', () => {
    const component = shallow(<Form stores={stores} />).dive();

    let elements = component.find('h5');
    assert.strictEqual(elements.length, 2);
    assert.strictEqual(elements.at(0).text(), 'Your Name:');
    assert.strictEqual(elements.at(1).text(), 'Comments:');

    assert.strictEqual(component.find('input').length, 1);
    assert.strictEqual(component.find('textarea').length, 1);

    elements = component.find('button');
    assert.strictEqual(elements.length, 1);
    assert.strictEqual(elements.at(0).text(), 'Submit');
  });

  it('should call setName when name input changes', () => {
    const page = shallow(<Form stores={stores} />).dive();
    const nameRow = page.find('input');

    const event = { target: { value: 'Alice' } };
    nameRow.simulate('change', event);
    assert(stores.feedbackStore.setName.calledWith('Alice'));
  });

  it('should call setComment when comment input changes', () => {
    const page = shallow(<Form stores={stores} />).dive();
    const commentRow = page.find('textarea');

    const event = { target: { value: 'Good!' } };
    commentRow.simulate('change', event);
    assert(stores.feedbackStore.setComment.calledWith('Good!'));
  });
});
