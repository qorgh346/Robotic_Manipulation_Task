
"use strict";

let PickupGoal = require('./PickupGoal.js');
let PickupResult = require('./PickupResult.js');
let MoveGroupAction = require('./MoveGroupAction.js');
let ExecuteTrajectoryFeedback = require('./ExecuteTrajectoryFeedback.js');
let PlaceActionFeedback = require('./PlaceActionFeedback.js');
let PlaceActionResult = require('./PlaceActionResult.js');
let ExecuteTrajectoryAction = require('./ExecuteTrajectoryAction.js');
let ExecuteTrajectoryGoal = require('./ExecuteTrajectoryGoal.js');
let ExecuteTrajectoryActionResult = require('./ExecuteTrajectoryActionResult.js');
let PlaceActionGoal = require('./PlaceActionGoal.js');
let ExecuteTrajectoryResult = require('./ExecuteTrajectoryResult.js');
let PickupActionResult = require('./PickupActionResult.js');
let PlaceFeedback = require('./PlaceFeedback.js');
let MoveGroupFeedback = require('./MoveGroupFeedback.js');
let PlaceAction = require('./PlaceAction.js');
let MoveGroupActionGoal = require('./MoveGroupActionGoal.js');
let ExecuteTrajectoryActionGoal = require('./ExecuteTrajectoryActionGoal.js');
let MoveGroupActionFeedback = require('./MoveGroupActionFeedback.js');
let PickupAction = require('./PickupAction.js');
let MoveGroupResult = require('./MoveGroupResult.js');
let ExecuteTrajectoryActionFeedback = require('./ExecuteTrajectoryActionFeedback.js');
let PlaceGoal = require('./PlaceGoal.js');
let PickupFeedback = require('./PickupFeedback.js');
let PickupActionFeedback = require('./PickupActionFeedback.js');
let MoveGroupGoal = require('./MoveGroupGoal.js');
let MoveGroupActionResult = require('./MoveGroupActionResult.js');
let PickupActionGoal = require('./PickupActionGoal.js');
let PlaceResult = require('./PlaceResult.js');
let PickupGoal = require('./PickupGoal.js');
let PickupResult = require('./PickupResult.js');
let MoveGroupAction = require('./MoveGroupAction.js');
let TrajectoryConstraints = require('./TrajectoryConstraints.js');
let AllowedCollisionMatrix = require('./AllowedCollisionMatrix.js');
let ExecuteTrajectoryFeedback = require('./ExecuteTrajectoryFeedback.js');
let PositionConstraint = require('./PositionConstraint.js');
let AllowedCollisionEntry = require('./AllowedCollisionEntry.js');
let PlaceActionFeedback = require('./PlaceActionFeedback.js');
let PlaceActionResult = require('./PlaceActionResult.js');
let ExecuteTrajectoryAction = require('./ExecuteTrajectoryAction.js');
let JointLimits = require('./JointLimits.js');
let PlanningSceneComponents = require('./PlanningSceneComponents.js');
let ExecuteTrajectoryGoal = require('./ExecuteTrajectoryGoal.js');
let PlanningSceneWorld = require('./PlanningSceneWorld.js');
let ExecuteTrajectoryActionResult = require('./ExecuteTrajectoryActionResult.js');
let PlannerInterfaceDescription = require('./PlannerInterfaceDescription.js');
let CostSource = require('./CostSource.js');
let PlaceActionGoal = require('./PlaceActionGoal.js');
let MoveItErrorCodes = require('./MoveItErrorCodes.js');
let RobotState = require('./RobotState.js');
let BoundingVolume = require('./BoundingVolume.js');
let PlanningScene = require('./PlanningScene.js');
let ExecuteTrajectoryResult = require('./ExecuteTrajectoryResult.js');
let PickupActionResult = require('./PickupActionResult.js');
let LinkPadding = require('./LinkPadding.js');
let ConstraintEvalResult = require('./ConstraintEvalResult.js');
let DisplayRobotState = require('./DisplayRobotState.js');
let PlaceFeedback = require('./PlaceFeedback.js');
let MoveGroupFeedback = require('./MoveGroupFeedback.js');
let OrientedBoundingBox = require('./OrientedBoundingBox.js');
let DisplayTrajectory = require('./DisplayTrajectory.js');
let WorkspaceParameters = require('./WorkspaceParameters.js');
let AttachedCollisionObject = require('./AttachedCollisionObject.js');
let GripperTranslation = require('./GripperTranslation.js');
let PlaceAction = require('./PlaceAction.js');
let MoveGroupActionGoal = require('./MoveGroupActionGoal.js');
let PlanningOptions = require('./PlanningOptions.js');
let MotionPlanRequest = require('./MotionPlanRequest.js');
let ExecuteTrajectoryActionGoal = require('./ExecuteTrajectoryActionGoal.js');
let Grasp = require('./Grasp.js');
let PositionIKRequest = require('./PositionIKRequest.js');
let MoveGroupActionFeedback = require('./MoveGroupActionFeedback.js');
let PickupAction = require('./PickupAction.js');
let MoveGroupResult = require('./MoveGroupResult.js');
let Constraints = require('./Constraints.js');
let ExecuteTrajectoryActionFeedback = require('./ExecuteTrajectoryActionFeedback.js');
let JointConstraint = require('./JointConstraint.js');
let VisibilityConstraint = require('./VisibilityConstraint.js');
let PlaceGoal = require('./PlaceGoal.js');
let PlaceLocation = require('./PlaceLocation.js');
let PickupFeedback = require('./PickupFeedback.js');
let PickupActionFeedback = require('./PickupActionFeedback.js');
let LinkScale = require('./LinkScale.js');
let MoveGroupGoal = require('./MoveGroupGoal.js');
let MotionPlanDetailedResponse = require('./MotionPlanDetailedResponse.js');
let OrientationConstraint = require('./OrientationConstraint.js');
let MotionPlanResponse = require('./MotionPlanResponse.js');
let MoveGroupActionResult = require('./MoveGroupActionResult.js');
let PickupActionGoal = require('./PickupActionGoal.js');
let CollisionObject = require('./CollisionObject.js');
let KinematicSolverInfo = require('./KinematicSolverInfo.js');
let ObjectColor = require('./ObjectColor.js');
let RobotTrajectory = require('./RobotTrajectory.js');
let PlannerParams = require('./PlannerParams.js');
let PlaceResult = require('./PlaceResult.js');
let ContactInformation = require('./ContactInformation.js');

module.exports = {
  PickupGoal: PickupGoal,
  PickupResult: PickupResult,
  MoveGroupAction: MoveGroupAction,
  ExecuteTrajectoryFeedback: ExecuteTrajectoryFeedback,
  PlaceActionFeedback: PlaceActionFeedback,
  PlaceActionResult: PlaceActionResult,
  ExecuteTrajectoryAction: ExecuteTrajectoryAction,
  ExecuteTrajectoryGoal: ExecuteTrajectoryGoal,
  ExecuteTrajectoryActionResult: ExecuteTrajectoryActionResult,
  PlaceActionGoal: PlaceActionGoal,
  ExecuteTrajectoryResult: ExecuteTrajectoryResult,
  PickupActionResult: PickupActionResult,
  PlaceFeedback: PlaceFeedback,
  MoveGroupFeedback: MoveGroupFeedback,
  PlaceAction: PlaceAction,
  MoveGroupActionGoal: MoveGroupActionGoal,
  ExecuteTrajectoryActionGoal: ExecuteTrajectoryActionGoal,
  MoveGroupActionFeedback: MoveGroupActionFeedback,
  PickupAction: PickupAction,
  MoveGroupResult: MoveGroupResult,
  ExecuteTrajectoryActionFeedback: ExecuteTrajectoryActionFeedback,
  PlaceGoal: PlaceGoal,
  PickupFeedback: PickupFeedback,
  PickupActionFeedback: PickupActionFeedback,
  MoveGroupGoal: MoveGroupGoal,
  MoveGroupActionResult: MoveGroupActionResult,
  PickupActionGoal: PickupActionGoal,
  PlaceResult: PlaceResult,
  PickupGoal: PickupGoal,
  PickupResult: PickupResult,
  MoveGroupAction: MoveGroupAction,
  TrajectoryConstraints: TrajectoryConstraints,
  AllowedCollisionMatrix: AllowedCollisionMatrix,
  ExecuteTrajectoryFeedback: ExecuteTrajectoryFeedback,
  PositionConstraint: PositionConstraint,
  AllowedCollisionEntry: AllowedCollisionEntry,
  PlaceActionFeedback: PlaceActionFeedback,
  PlaceActionResult: PlaceActionResult,
  ExecuteTrajectoryAction: ExecuteTrajectoryAction,
  JointLimits: JointLimits,
  PlanningSceneComponents: PlanningSceneComponents,
  ExecuteTrajectoryGoal: ExecuteTrajectoryGoal,
  PlanningSceneWorld: PlanningSceneWorld,
  ExecuteTrajectoryActionResult: ExecuteTrajectoryActionResult,
  PlannerInterfaceDescription: PlannerInterfaceDescription,
  CostSource: CostSource,
  PlaceActionGoal: PlaceActionGoal,
  MoveItErrorCodes: MoveItErrorCodes,
  RobotState: RobotState,
  BoundingVolume: BoundingVolume,
  PlanningScene: PlanningScene,
  ExecuteTrajectoryResult: ExecuteTrajectoryResult,
  PickupActionResult: PickupActionResult,
  LinkPadding: LinkPadding,
  ConstraintEvalResult: ConstraintEvalResult,
  DisplayRobotState: DisplayRobotState,
  PlaceFeedback: PlaceFeedback,
  MoveGroupFeedback: MoveGroupFeedback,
  OrientedBoundingBox: OrientedBoundingBox,
  DisplayTrajectory: DisplayTrajectory,
  WorkspaceParameters: WorkspaceParameters,
  AttachedCollisionObject: AttachedCollisionObject,
  GripperTranslation: GripperTranslation,
  PlaceAction: PlaceAction,
  MoveGroupActionGoal: MoveGroupActionGoal,
  PlanningOptions: PlanningOptions,
  MotionPlanRequest: MotionPlanRequest,
  ExecuteTrajectoryActionGoal: ExecuteTrajectoryActionGoal,
  Grasp: Grasp,
  PositionIKRequest: PositionIKRequest,
  MoveGroupActionFeedback: MoveGroupActionFeedback,
  PickupAction: PickupAction,
  MoveGroupResult: MoveGroupResult,
  Constraints: Constraints,
  ExecuteTrajectoryActionFeedback: ExecuteTrajectoryActionFeedback,
  JointConstraint: JointConstraint,
  VisibilityConstraint: VisibilityConstraint,
  PlaceGoal: PlaceGoal,
  PlaceLocation: PlaceLocation,
  PickupFeedback: PickupFeedback,
  PickupActionFeedback: PickupActionFeedback,
  LinkScale: LinkScale,
  MoveGroupGoal: MoveGroupGoal,
  MotionPlanDetailedResponse: MotionPlanDetailedResponse,
  OrientationConstraint: OrientationConstraint,
  MotionPlanResponse: MotionPlanResponse,
  MoveGroupActionResult: MoveGroupActionResult,
  PickupActionGoal: PickupActionGoal,
  CollisionObject: CollisionObject,
  KinematicSolverInfo: KinematicSolverInfo,
  ObjectColor: ObjectColor,
  RobotTrajectory: RobotTrajectory,
  PlannerParams: PlannerParams,
  PlaceResult: PlaceResult,
  ContactInformation: ContactInformation,
};
