
import { createStore, applyMiddleware, combineReducers, compose } from "redux";
import thunkMiddleware from "redux-thunk";
import userReducer from "./ducks/user";

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const middleware = composeEnhancers(applyMiddleware(thunkMiddleware));
const reducer = combineReducers({
  user: userReducer,
});

const configureStore = (initialState) => { return createStore(reducer, initialState, middleware) }

export default configureStore;
