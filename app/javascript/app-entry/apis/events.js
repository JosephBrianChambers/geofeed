import Axios from 'axios';

const axiosInstance = Axios.create({
  baseURL: 'http://localhost:3001/api/',
  timeout: 1000,
  headers: {'X-Custom-Header': 'foobar'}
});


const create = (eventAttrs) => {
  return axiosInstance.post('/events', { 'event': eventAttrs })
};

const fetchContent = (eventId) => {
  return axiosInstance.get(`/events/${eventId}/fetch_content`)
}

const get = (eventId) => {
  return axiosInstance.get(`/events/${eventId}`)
}

export default { create, fetchContent, get }
