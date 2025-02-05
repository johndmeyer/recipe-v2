using Data;
using DataModels;

namespace Logic
{
    public interface ILogicRecipe
    {
        ResponseObject<ResponseObjectRecipeFull> CreateRecipe(RecipeFull recipe);
        ResponseObject<object> DeleteRecipe(int recipeId);
        ResponseObject<ResponseObjectRecipeFull> RetrieveRecipe(int recipeId);
        ResponseObject<ResponseObjectListRecipeBase> RetrieveRecipes(int? recipeCookTime, int? recipeDifficultyId, int? recipeTagId);
        ResponseObject<ResponseObjectRecipeFull> UpdateRecipe(RecipeFull recipe);
    } // end interface
    
    public class LogicRecipe(IDataRecipe dataRecipe) : LogicBase, ILogicRecipe
    {
        // This is currently mostly just a pass through tier, but if we wanted more complex logic this is where it would go
        
        public ResponseObject<ResponseObjectRecipeFull> CreateRecipe(RecipeFull recipe)
        {
            try
            {
                return new ResponseObject<ResponseObjectRecipeFull>
                {
                    Data = new ResponseObjectRecipeFull
                    {
                        Recipe = dataRecipe.CreateRecipe(recipe).Result.FirstOrDefault()
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectRecipeFull>(e);
            }
        } // end
        
        public ResponseObject<object> DeleteRecipe(int recipeId)
        {
            try
            {
                dataRecipe.DeleteRecipe(recipeId);

                return new ResponseObject<object>();
            }
            catch (Exception e)
            {
                return BuildErrorObject<object>(e);
            }
        } // end

        public ResponseObject<ResponseObjectRecipeFull> RetrieveRecipe(int recipeId)
        {
            try
            {
                return new ResponseObject<ResponseObjectRecipeFull>
                {
                    Data = new ResponseObjectRecipeFull
                    {
                        Recipe = dataRecipe.RetrieveRecipe(recipeId).Result.FirstOrDefault()
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectRecipeFull>(e);
            }
        } // end

        public ResponseObject<ResponseObjectListRecipeBase> RetrieveRecipes(int? recipeCookTime, int? recipeDifficultyId, int? recipeTagId)
        {
            try
            {
                return new ResponseObject<ResponseObjectListRecipeBase>
                {
                    Data = new ResponseObjectListRecipeBase
                    {
                        Recipes = dataRecipe.RetrieveRecipes(recipeCookTime, recipeDifficultyId, recipeTagId).Result
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectListRecipeBase>(e);
            }
        } // end

        public ResponseObject<ResponseObjectRecipeFull> UpdateRecipe(RecipeFull recipe)
        {
            try
            {
                return new ResponseObject<ResponseObjectRecipeFull>
                {
                    Data = new ResponseObjectRecipeFull
                    {
                        Recipe = dataRecipe.UpdateRecipe(recipe).Result.FirstOrDefault()
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectRecipeFull>(e);
            }
        } // end
    } // end class
} // end namespace
