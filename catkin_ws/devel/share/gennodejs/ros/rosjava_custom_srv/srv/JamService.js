// Auto-generated. Do not edit!

// (in-package rosjava_custom_srv.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class JamServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.path = null;
    }
    else {
      if (initObj.hasOwnProperty('path')) {
        this.path = initObj.path
      }
      else {
        this.path = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type JamServiceRequest
    // Serialize message field [path]
    bufferOffset = _serializer.string(obj.path, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type JamServiceRequest
    let len;
    let data = new JamServiceRequest(null);
    // Deserialize message field [path]
    data.path = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.path.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosjava_custom_srv/JamServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1d00cd540af97efeb6b1589112fab63e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string path
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new JamServiceRequest(null);
    if (msg.path !== undefined) {
      resolved.path = msg.path;
    }
    else {
      resolved.path = ''
    }

    return resolved;
    }
};

class JamServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.res = null;
    }
    else {
      if (initObj.hasOwnProperty('res')) {
        this.res = initObj.res
      }
      else {
        this.res = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type JamServiceResponse
    // Serialize message field [res]
    bufferOffset = _serializer.string(obj.res, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type JamServiceResponse
    let len;
    let data = new JamServiceResponse(null);
    // Deserialize message field [res]
    data.res = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.res.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosjava_custom_srv/JamServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '53af918a2a4a2a182c184142fff49b0c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string res
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new JamServiceResponse(null);
    if (msg.res !== undefined) {
      resolved.res = msg.res;
    }
    else {
      resolved.res = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: JamServiceRequest,
  Response: JamServiceResponse,
  md5sum() { return '31d2fe905e359df0b2a8510339b9b736'; },
  datatype() { return 'rosjava_custom_srv/JamService'; }
};
