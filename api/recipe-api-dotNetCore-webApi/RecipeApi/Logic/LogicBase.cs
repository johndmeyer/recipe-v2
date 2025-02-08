using DataModels;

namespace Logic
{
    public class LogicBase
    {
        /// <summary>
        /// This is a generic method that builds a hierarchical tree from flat data. It could be much shorter, but
        /// because the logic here is complex due to the generics and use of reflection I've removed all the LINQ
        /// and other syntactic sugar.
        /// </summary>
        /// <param name="data"></param>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public IEnumerable<T> BuildObjectTree<T>(List<T> data)
        {
            var id = $"{typeof(T).Name}Id";
            var idParent = $"{typeof(T).Name}IdParent";
            
            foreach (var dataItem1 in data)
            {
                var children = new List<T>();
                
                var dataItem1Id = dataItem1.GetType().GetProperty(id).GetValue(dataItem1);

                foreach (var dataItem2 in data)
                {
                    var dataItem2Id = dataItem2.GetType().GetProperty(idParent).GetValue(dataItem2);

                    if (dataItem1Id.Equals(dataItem2Id))
                    {
                        children.Add(dataItem2);
                    }
                }

                dataItem1.GetType().GetProperty("Items").SetValue(dataItem1, children);
            }

            var results = new List<T>();

            foreach (var dataItem3 in data)
            {
                var dataItem3IdParent = dataItem3.GetType().GetProperty(idParent).GetValue(dataItem3);
                
                if (dataItem3IdParent == null)
                {
                    results.Add(dataItem3);
                }
            }
        
            return results;
        } // end
        
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

