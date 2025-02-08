namespace DataModels
{
    /// <summary>
    /// Response Object Containing Tag Data Model Object
    /// </summary>
    public class ResponseObjectTag
    {
        public Tag? Tag { get; set; }
    } // end

    /// <summary>
    /// Response Object Containing List Of Tag Data Model Objects
    /// </summary>
    public class ResponseObjectListTag
    {
        public IEnumerable<Tag> Tags { get; set; } = new List<Tag>();
    } // end
    
    /// <summary>
    /// Recipe Tag Data Model Object
    /// </summary>
    public class Tag
    {
        public int? TagId { get; set; }

        public int? TagIdParent { get; set; }

        public required string TagName { get; set; }
        
        public IEnumerable<Tag> Items { get; set; }
    } // end class
} // end namespace
