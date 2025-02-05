using System.Collections;
using System.Dynamic;

namespace DataModels
{
    public class ResponseObject<T>
    {
        public T Data { get; set; }
        
        public ErrorObject? Error { get; set; }
    } // end
    
    public class ErrorObject
    {
        public int StatusCode { get; set; }
        public string Message { get; set; }
        public IEnumerable<Error> Errors { get; set; }
    } // end

    public class Error
    {
        public string Message { get; set; }
        
        public string Reason { get; set; }
    } // end
} // end namespace