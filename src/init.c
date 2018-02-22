#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP _teachingApps_dbeta4(SEXP xSEXP, SEXP minSEXP, SEXP maxSEXP, SEXP shape1SEXP, SEXP shape2SEXP, SEXP gapSEXP);
extern SEXP _teachingApps_dbisa(SEXP xSEXP, SEXP shapeSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_dlbisa(SEXP zSEXP, SEXP shapeSEXP);
extern SEXP _teachingApps_dlev(SEXP xSEXP, SEXP locSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_dsev(SEXP xSEXP, SEXP locSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_likely2(SEXP timesSEXP, SEXP censSEXP, SEXP paramsSEXP, SEXP maxllSEXP);
extern SEXP _teachingApps_pbeta4(SEXP qSEXP, SEXP minSEXP, SEXP maxSEXP, SEXP shape1SEXP, SEXP shape2SEXP, SEXP gapSEXP);
extern SEXP _teachingApps_pbisa(SEXP qSEXP, SEXP shapeSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_plev(SEXP qSEXP, SEXP locSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_psev(SEXP qSEXP, SEXP locSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_qbeta4(SEXP pSEXP, SEXP minSEXP, SEXP maxSEXP, SEXP shape1SEXP, SEXP shape2SEXP);
extern SEXP _teachingApps_qbisa(SEXP pSEXP, SEXP shapeSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_qlev(SEXP pSEXP, SEXP locSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_qsev(SEXP pSEXP, SEXP locSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_rbeta4(SEXP nSEXP, SEXP minSEXP, SEXP maxSEXP, SEXP shape1SEXP, SEXP shape2SEXP);
extern SEXP _teachingApps_rbisa(SEXP nSEXP, SEXP shapeSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_rcpp_hello_world();
extern SEXP _teachingApps_rlev(SEXP nSEXP, SEXP locSEXP, SEXP scaleSEXP);
extern SEXP _teachingApps_rsev(SEXP nSEXP, SEXP locSEXP, SEXP scaleSEXP);

static const R_CallMethodDef CallEntries[] = {
    {"_teachingApps_dbeta4",           (DL_FUNC) &_teachingApps_dbeta4,           6},
    {"_teachingApps_dbisa",            (DL_FUNC) &_teachingApps_dbisa,            3},
    {"_teachingApps_dlbisa",           (DL_FUNC) &_teachingApps_dlbisa,           2},
    {"_teachingApps_dlev",             (DL_FUNC) &_teachingApps_dlev,             3},
    {"_teachingApps_dsev",             (DL_FUNC) &_teachingApps_dsev,             3},
    {"_teachingApps_likely2",          (DL_FUNC) &_teachingApps_likely2,          4},
    {"_teachingApps_pbeta4",           (DL_FUNC) &_teachingApps_pbeta4,           6},
    {"_teachingApps_pbisa",            (DL_FUNC) &_teachingApps_pbisa,            3},
    {"_teachingApps_plev",             (DL_FUNC) &_teachingApps_plev,             3},
    {"_teachingApps_psev",             (DL_FUNC) &_teachingApps_psev,             3},
    {"_teachingApps_qbeta4",           (DL_FUNC) &_teachingApps_qbeta4,           5},
    {"_teachingApps_qbisa",            (DL_FUNC) &_teachingApps_qbisa,            3},
    {"_teachingApps_qlev",             (DL_FUNC) &_teachingApps_qlev,             3},
    {"_teachingApps_qsev",             (DL_FUNC) &_teachingApps_qsev,             3},
    {"_teachingApps_rbeta4",           (DL_FUNC) &_teachingApps_rbeta4,           5},
    {"_teachingApps_rbisa",            (DL_FUNC) &_teachingApps_rbisa,            3},
    {"_teachingApps_rcpp_hello_world", (DL_FUNC) &_teachingApps_rcpp_hello_world, 0},
    {"_teachingApps_rlev",             (DL_FUNC) &_teachingApps_rlev,             3},
    {"_teachingApps_rsev",             (DL_FUNC) &_teachingApps_rsev,             3},
    {NULL, NULL, 0}
};

void R_init_teachingApps(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}