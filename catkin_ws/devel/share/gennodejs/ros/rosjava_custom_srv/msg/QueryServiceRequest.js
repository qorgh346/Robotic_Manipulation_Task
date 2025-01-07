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

class QueryServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.query = null;
      this.manager = null;
    }
    else {
      if (initObj.hasOwnProperty('query')) {
        this.query = initObj.query
      }
      else {
        this.query = '';
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
    // Serializes a message object of type QueryServiceRequest
    // Serialize message field [query]
    bufferOffset = _serializer.string(obj.query, buffer, bufferOffset);
    // Serialize message field [manager]
    bufferOffset = _serializer.string(obj.manager, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type QueryServiceRequest
    let len;
    let data = new QueryServiceRequest(null);
    // Deserialize message field [query]
    data.query = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [manager]
    data.manager = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.query.length;
    length += object.manager.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosjava_custom_srv/QueryServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c87ac28ec8f021755cccae1836d04e07';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string query
    string manager
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new QueryServiceRequest(null);
    if (msg.query !== undefined) {
      resolved.query = msg.query;
    }
    else {
      resolved.query = ''
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

module.exports = QueryServiceRequest;
