import app/websocket
import wisp

// We need to store the websocket capability provided by our server which we
// will use to create a websocket route. This provides the connection
// information of the socket connection to be upgraded into a websocket.
// We will need to define in our capability our type for our websockets
// state and the custom message type it will receive.
pub type Context {
  Context(ws: wisp.WsCapability(websocket.State, String))
}

pub fn middleware(
  req: wisp.Request,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  let req = wisp.method_override(req)
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)

  handle_request(req)
}
