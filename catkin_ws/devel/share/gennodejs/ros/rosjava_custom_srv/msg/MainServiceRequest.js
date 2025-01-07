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

class MainServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.predicate = null;
      this.param1 = null;
      this.param2 = null;
      this.param3 = null;
      this.param4 = null;
      this.status = null;
      this.manager = null;
    }
    else {
      if (initObj.hasOwnProperty('predicate')) {
        this.predicate = initObj.predicate
      }
      else {
        this.predicate = [];
      }
      if (initObj.hasOwnProperty('param1')) {
        this.param1 = initObj.param1
      }
      else {
        this.param1 = [];
      }
      if (initObj.hasOwnProperty('param2')) {
        this.param2 = initObj.param2
      }
      else {
        this.param2 = [];
      }
      if (initObj.hasOwnProperty('param3')) {
        this.param3 = initObj.param3
      }
      else {
        this.param3 = [];
      }
      if (initObj.hasOwnProperty('param4')) {
        this.param4 = initObj.param4
      }
      else {
        this.param4 = [];
      }
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = [];
      }
      if (initObj.hasOwnProperty('manager')) {
        this.manager = initObj.manager
      }
      else {
        this.manager = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MainServiceRequest
    // Serialize message field [predicate]
    bufferOffset = _arraySerializer.string(obj.predicate, buffer, bufferOffset, null);
    // Serialize message field [param1]
    bufferOffset = _arraySerializer.string(obj.param1, buffer, bufferOffset, null);
    // Serialize message field [param2]
    bufferOffset = _arraySerializer.string(obj.param2, buffer, bufferOffset, null);
    // Serialize message field [param3]
    bufferOffset = _arraySerializer.string(obj.param3, buffer, bufferOffset, null);
    // Serialize message field [param4]
    bufferOffset = _arraySerializer.string(obj.param4, buffer, bufferOffset, null);
    // Serialize message field [status]
    bufferOffset = _arraySerializer.int32(obj.status, buffer, bufferOffset, null);
    // Serialize message field [manager]
    bufferOffset = _serializer.string(obj.manager, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MainServiceRequest
    let len;
    let data = new MainServiceRequest(null);
    // Deserialize message field [predicate]
    data.predicate = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [param1]
    data.param1 = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [param2]
    data.param2 = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [param3]
    data.param3 = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [param4]
    data.param4 = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [status]
    data.status = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [manager]
    data.manager = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.predicate.forEach((val) => {
      length += 4 + val.length;
    });
    object.param1.forEach((val) => {
      length += 4 + val.length;
    });
    object.param2.forEach((val) => {
      length += 4 + val.length;
    });
    object.param3.forEach((val) => {
      length += 4 + val.length;
    });
    object.param4.forEach((val) => {
      length += 4 + val.length;
    });
    length += 4 * object.status.length;
    length += object.manager.length;
    return length + 28;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosjava_custom_srv/MainServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1ab506786d6907c7cafe1222b90fc169';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string[] predicate
    string[] param1
    string[] param2
    string[] param3
    string[] param4
    
    int32[] status
    string manager
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MainServiceRequest(null);
    if (msg.predicate !== undefined) {
      resolved.predicate = msg.predicate;
    }
    else {
      resolved.predicate = []
    }

    if (msg.param1 !== undefined) {
      resolved.param1 = msg.param1;
    }
    else {
      resolved.param1 = []
    }

    if (msg.param2 !== undefined) {
      resolved.param2 = msg.param2;
    }
    else {
      resolved.param2 = []
    }

    if (msg.param3 !== undefined) {
      resolved.param3 = msg.param3;
    }
    else {
      resolved.param3 = []
    }

    if (msg.param4 !== undefined) {
      resolved.param4 = msg.param4;
    }
    else {
      resolved.param4 = []
    }

    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = []
    }

    if (msg.manager !== undefined) {
      resolved.manager = msg.manager;
    }
    else {
      resolved.manager = ''
    }

    return resolved;
    }
};

module.exports = MainServiceRequest;
