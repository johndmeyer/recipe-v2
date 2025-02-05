namespace DataModels
{
    /// <summary>
    /// Response Object Containing List Of Base Recipe Data Model Objects
    /// </summary>
    public class ResponseObjectListDifficulty
    {
        public IEnumerable<Difficulty> Difficultys { get; set; } = new List<Difficulty>();
    } // end
    
    /// <summary>
    /// Recipe Difficulty Data Model Object
    /// </summary>
    public class Difficulty
    {
        public int DifficultyId { get; set; }
        
        public string? DifficultyName { get; set; }
    } // end class
} // end namespace

