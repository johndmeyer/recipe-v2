using DataModels;

namespace Logic
{
    public class LogicBase
    {
        public ResponseObject<T> BuildErrorObject<T>(Exception exception)
        {
            // TODO: Configure exception logging
            
            return new ResponseObject<T>
            {
                Error = new ErrorObject
                {
                    Message = exception.StackTrace
                }
            };
        }
    }
}

