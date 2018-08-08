import Axios from 'axios';

const axiosInstance = Axios.create({
  baseURL: 'http://localhost:3001/api/',
  timeout: 1000,
});

const get = (eventId) => {
  return axiosInstance.get(`/moments/${eventId}`)
}

export default { get }
