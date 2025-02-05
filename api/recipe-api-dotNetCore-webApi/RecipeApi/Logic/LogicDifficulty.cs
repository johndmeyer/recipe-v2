using Data;
using DataModels;

namespace Logic
{
    public interface ILogicDifficulty
    {
        ResponseObject<ResponseObjectListDifficulty>  RetrieveDifficulties();
    } // end interface

    public class LogicDifficulty (IDataDifficulty dataDifficulty) : LogicBase, ILogicDifficulty
    {
        public ResponseObject<ResponseObjectListDifficulty>  RetrieveDifficulties()
        {
            try
            {
                return new ResponseObject<ResponseObjectListDifficulty>
                {
                    Data = new ResponseObjectListDifficulty
                    {
                        Difficultys = dataDifficulty.RetrieveDifficulties().Result
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectListDifficulty>(e);
            }
        } // end
    } // end class
} // end namespace