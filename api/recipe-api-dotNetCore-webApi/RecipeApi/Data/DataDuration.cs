using DataModels;
namespace Data
{
    public interface IDataDuration
    {
        Task<IEnumerable<Duration>> RetrieveDurations();
    } // end interface
    
    public class DataDuration : DataBase, IDataDuration
    {
        public DataDuration(IDapperDbConnection dapperDbConnection):base(dapperDbConnection) { } // end constructor

        public async Task<IEnumerable<Duration>> RetrieveDurations()
        {
            var task = Task.Run(() => new List<Duration> {

                new Duration(durationId: 30, durationName: "30 minutes or less"),
                new Duration(durationId: 60, durationName: "60 minutes or less"),
                new Duration(durationId: 90, durationName: "90 minutes or less")
            });

            return await task;
        } // end
    } // end class
} // end namespace