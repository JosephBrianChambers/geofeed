import update from 'immutability-helper';
import { createAction } from 'redux-actions';

// Actions
const UPDATE_USER = 'user/UPDATE_USER';

// Reducers
export const userInitialState = {
  name: '',
};

export default function userReducer(state = userInitialState, action) {
  switch (action.type) {
    case UPDATE_USER: {
      return update(state, { $merge: action.payload });
    }
    default: {
      return state;
    }
  }
}

// Action Creators
export const updateUser = createAction(UPDATE_USER);


