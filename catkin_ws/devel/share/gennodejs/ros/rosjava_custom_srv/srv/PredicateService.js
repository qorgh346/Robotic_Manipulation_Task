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

class PredicateServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.predicate = null;
      this.param1 = null;
      this.param2 = null;
      this.param3 = null;
      this.param4 = null;
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
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PredicateServiceRequest
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
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PredicateServiceRequest
    let len;
    let data = new PredicateServiceRequest(null);
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
    return length + 20;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosjava_custom_srv/PredicateServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '380fc1b6cb3cf53bfd53599189a579bc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string[] predicate
    string[] param1
    string[] param2
    string[] param3
    string[] param4
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PredicateServiceRequest(null);
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

    return resolved;
    }
};

class PredicateServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.result = null;
    }
    else {
      if (initObj.hasOwnProperty('result')) {
        this.result = initObj.result
      }
      else {
        this.result = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PredicateServiceResponse
    // Serialize message field [result]
    bufferOffset = _serializer.int32(obj.result, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PredicateServiceResponse
    let len;
    let data = new PredicateServiceResponse(null);
    // Deserialize message field [result]
    data.result = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosjava_custom_srv/PredicateServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '034a8e20d6a306665e3a5b340fab3f09';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 result
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PredicateServiceResponse(null);
    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: PredicateServiceRequest,
  Response: PredicateServiceResponse,
  md5sum() { return 'aedf4a39ef72018907356ccb3fd7b3f3'; },
  datatype() { return 'rosjava_custom_srv/PredicateService'; }
};
