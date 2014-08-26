/**
 * General Purpose Block Type for Callbacks
 *
 * @param error If the method execution was failed, this is the reason. If this is nil, the method execution was successful.
 * @param result The result of the method execution
 */
typedef void (^OnTaskComplete)(NSError *error, id result);
