namespace DataModels
{
    public class DataModelsTag
    {
        /// <summary>
        /// Tag Data Model Object
        /// </summary>
        public class Tag
        {
            public int TagId { get; set; }

            public int TagIdParent { get; set; }

            public string? TagName { get; set; }
        } // end
    } // end class
} // end namespace
