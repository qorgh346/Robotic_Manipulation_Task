// Auto-generated. Do not edit!

// (in-package rosjava_custom_srv.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ActionResultMsg {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.actionStatus = null;
    }
    else {
      if (initObj.hasOwnProperty('actionStatus')) {
        this.actionStatus = initObj.actionStatus
      }
      else {
        this.actionStatus = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ActionResultMsg
    // Serialize message field [actionStatus]
    bufferOffset = _serializer.int32(obj.actionStatus, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ActionResultMsg
    let len;
    let data = new ActionResultMsg(null);
    // Deserialize message field [actionStatus]
    data.actionStatus = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosjava_custom_srv/ActionResultMsg';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd0d63bd7875eb84a563aa44f75268f19';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 actionStatus
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ActionResultMsg(null);
    if (msg.actionStatus !== undefined) {
      resolved.actionStatus = msg.actionStatus;
    }
    else {
      resolved.actionStatus = 0
    }

    return resolved;
    }
};

module.exports = ActionResultMsg;
