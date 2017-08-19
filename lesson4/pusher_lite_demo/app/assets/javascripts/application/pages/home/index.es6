import {Socket} from "phoenix"

export default class Index {
  constructor(root) {
    this.root = root;
  }

  setup() {
    // add event listeners
    console.log('-> Setting up Pusher Lite socket')
    // let guardianToken = $("meta[name=guardian-token]").attr("content")
    // let csrfToken     = $("meta[name=guardian-csrf]").attr("content")

    let pusherHost    = $("meta[name=pusher_host]").attr("content")
   // let pusherApp     = $("meta[name=pusher_app_id]").attr("content")
    let pusherApp     = $("meta[name=pusher_app_id]").attr("content")
    let pusherChannel = $("meta[name=pusher_channel]").attr("content")

    let socket = new Socket(`ws://${pusherHost}/socket`, {
      // params: { guardian_token: guardianToken, csrf_token: csrfToken }
    })
    socket.connect()

    // Now that you are connected, you can join channels with a topic:
    let channel = socket.channel(`public:${pusherApp}`, {})
    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    channel.on(`${pusherChannel}:msg`, data => {
      let new_line = `<div><p><strong>${data.name}<strong>: ${data.message}</p></div>`
      $(".message-receiver").append(new_line)
    })

    channel.on("msg", data => {
      let new_line = `<div><p><strong>Broadcast to all channels</strong>${data.message}</p></div>`
      $(".message-receiver").append(new_line)
    })
  }

  run() {
    // trigger initial action (e.g. perform http requests)
    console.log('-> perform initial actions')
  }

}
