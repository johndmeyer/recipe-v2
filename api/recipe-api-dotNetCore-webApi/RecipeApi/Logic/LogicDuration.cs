using Data;
using DataModels;

namespace Logic
{
    public interface ILogicDuration
    {
        ResponseObject<ResponseObjectListDuration> RetrieveDurations();
    } // end interface

    public class LogicDuration(IDataDuration dataDuration) : LogicBase, ILogicDuration
    {
        public ResponseObject<ResponseObjectListDuration> RetrieveDurations()
        {
            try
            {
                return new ResponseObject<ResponseObjectListDuration>
                {
                    Data = new ResponseObjectListDuration
                    {
                        Durations = dataDuration.RetrieveDurations().Result
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectListDuration>(e);
            }
        } // end
    } // end class
} // end namespace