let isDevelopment = process.env.NODE_ENV == "development"
const protocol = isDevelopment ? "http://" : "https://";

export const API = {
  version: "1",
  protocol: protocol,
  host: "localhost:5000"
}; 