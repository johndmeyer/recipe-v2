using Data;
using DataModels;

namespace Logic
{
    public interface ILogicTag
    {
        ResponseObject<ResponseObjectTag> CreateTag(Tag tag);
        ResponseObject<object> DeleteTag(int tagId);
        ResponseObject<ResponseObjectListTag> RetrieveTags();
        ResponseObject<ResponseObjectTag> UpdateTag(Tag tag);
    } // end interface

    public class LogicTag(IDataTag dataTag) : LogicBase, ILogicTag
    {
        public ResponseObject<ResponseObjectTag> CreateTag(Tag tag)
        {
            try
            {
                return new ResponseObject<ResponseObjectTag>
                {
                    Data = new ResponseObjectTag
                    {
                        Tag = dataTag.CreateTag(tag).Result.FirstOrDefault()
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectTag>(e);
            }
        } // end
        
        public ResponseObject<object> DeleteTag(int tagId)
        {
            try
            {
                dataTag.DeleteTag(tagId);
                
                return new ResponseObject<object>();
            }
            catch (Exception e)
            {
                return BuildErrorObject<object>(e);
            }
        } // end

        public ResponseObject<ResponseObjectListTag> RetrieveTags()
        {
            try
            {
                var tags = dataTag.RetrieveTags().Result;
                
                return new ResponseObject<ResponseObjectListTag>
                {
                    Data = new ResponseObjectListTag
                    {
                        Tags = BuildObjectTree(tags.ToList())
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectListTag>(e);
            }
        } // end
        
        public ResponseObject<ResponseObjectTag> UpdateTag(Tag tag)
        {
            try
            {
                return new ResponseObject<ResponseObjectTag>
                {
                    Data = new ResponseObjectTag
                    {
                        Tag = dataTag.UpdateTag(tag).Result.FirstOrDefault()
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectTag>(e);
            }
        } // end
    } // end class
} // end namespace