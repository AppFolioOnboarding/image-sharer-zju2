import { describe, it } from 'mocha';

import FeedbackStore from '../../stores/FeedbackStore';

const assert = require('assert');

describe('test my FeedbackStore', () => {
  it('Initialization should work correctly', () => {
    const store = new FeedbackStore();
    assert.strictEqual(store.name, '');
    assert.strictEqual(store.comment, '');
  });

  it('it should set name correctly', () => {
    const store = new FeedbackStore();

    store.setName('Adam');
    assert.strictEqual(store.name, 'Adam');
    assert.strictEqual(store.comment, '');
  });

  it('it should set comment correctly', () => {
    const store = new FeedbackStore();

    store.setComment('Hello!');
    assert.strictEqual(store.name, '');
    assert.strictEqual(store.comment, 'Hello!');
  });
});
