namespace DataModels
{
    /// <summary>
    /// Response Object Containing List Of Base Recipe Data Model Objects
    /// </summary>
    public class ResponseObjectListDuration
    {
        public IEnumerable<Duration> Durations { get; set; } = new List<Duration>();
    } // end
    
    /// <summary>
    /// Recipe Duration Data Model Object
    /// </summary>
    public class Duration(int durationId, string durationName)
    {
        public int DurationId { get; set; } = durationId;

        public string DurationName { get; set; } = durationName;
    } // end class
} // end namespace

